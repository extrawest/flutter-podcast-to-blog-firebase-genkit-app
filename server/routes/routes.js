import express from 'express';
import multer from 'multer';

const router = express.Router();
const upload = multer({ dest: 'uploads/' });

import { ImageRepository } from '../repositories/imageRepository.js';

import { SummarizerRepository } from '../repositories/summarizerRepository.js';

import { ChatRepository } from '../repositories/chatRepository.js';
import { SpeechToTextRepository } from '../repositories/speechToTextRepository.js';

import { TextToAudioRepository } from '../repositories/textToAudioRepository.js';
import { PodcastIndexRepository } from '../repositories/podcastIndexRepository.js';
import repositoryManager from '../repositories/repositoryManager.js';
import { TranslationRepository } from '../repositories/translationRepository.js';

router.post('/image', async (req, res) => {
    const imageRepository = new ImageRepository();
    try {
        const { text } = req.body;
        const image = await imageRepository.performTextToImage(text);
        res.json({ image: image });
    } catch (error) {
        res.status(500).json({ error: error.message, stack: error.stack });
    }
});

router.post('/convert_speech', upload.single('audio'), async (req, res) => {
    const speechToTextRepository = new SpeechToTextRepository(
        repositoryManager.getHuggingFaceRepository()
    );
    try {
        await speechToTextRepository.init();

        const filePath = req.file.path;
        const text = await speechToTextRepository.performSpeechToText(filePath);
        res.json({ text });
    } catch (error) {
        console.error('Error in /convertSpeech:', error);
        res.status(500).json({ error: error.message });
    }
});

router.post('/episodes', async (req, res) => {
    const podcastIndexRepository = new PodcastIndexRepository(
        repositoryManager.getPodcastIndexRepository()
    );
    try {
        const { searchTerm, limit, offset } = req.body;

        const podcast = await podcastIndexRepository.performPodcastSearch({
            searchTerm,
            limit,
            offset,
        });

        res.json(podcast);
    } catch (error) {
        console.error('Error in /episodes:', error);
        console.error('Error stack:', error.stack);
        res.status(500).json({ error: error.message, stack: error.stack });
    }
});
router.post('/episode_summary', async (req, res) => {
    const speechToTextRepository = new SpeechToTextRepository(
        repositoryManager.getHuggingFaceRepository()
    );
    const summaryRepository = new SummarizerRepository();
    const podcastIndexRepository = new PodcastIndexRepository(
        repositoryManager.getPodcastIndexRepository()
    );
    try {
        const { searchTerm } = req.body;
        if (!speechToTextRepository.isReady()) {
            await speechToTextRepository.init();
        }
        const podcast = await podcastIndexRepository.performEpisodesByIdSearch(
            searchTerm
        );

        const fileUrl = podcast.episode.enclosureUrl;
        const localFilePath = await speechToTextRepository.performDownloadFile(
            fileUrl
        );

        const text = await speechToTextRepository.performSpeechToText(
            localFilePath
        );

        // await summaryRepository.init();
        const summary = await summaryRepository.performSummarization(text);

        res.json(summary);
    } catch (error) {
        console.error('Error in /episode_summary:', error);
        console.error('Error stack:', error.stack);
        res.status(500).json({ error: error.message, stack: error.stack });
    }
});

router.post('/episode_speech_to_text', async (req, res) => {
    const speechToTextRepository = new SpeechToTextRepository(
        repositoryManager.getHuggingFaceRepository()
    );
    const podcastIndexRepository = new PodcastIndexRepository(
        repositoryManager.getPodcastIndexRepository()
    );
    try {
        await speechToTextRepository.init();

        const { searchTerm, limit, offset } = req.body;

        const podcast = await podcastIndexRepository.performEpisodesByIdSearch(
            searchTerm
        );
        const fileUrl = podcast.episode.enclosureUrl;
        const localFilePath = await speechToTextRepository.performDownloadFile(
            fileUrl
        );
        const text = await speechToTextRepository.performSpeechToText(
            localFilePath
        );

        res.json(text);
    } catch (error) {
        console.error('Error in /episode_speech_to_text:', error);
        console.error('Error stack:', error.stack);
        res.status(500).json({ error: error.message, stack: error.stack });
    }
});

router.post('/audio_summary', async (req, res) => {
    const textToAudioRepository = new TextToAudioRepository(
        repositoryManager.getElevenLabsRepository()
    );

    try {
        const { summaryText } = req.body;

        const audioBuffer = await textToAudioRepository.performTextToAudio(
            summaryText
        );

        res.set('Content-Type', 'audio/mpeg');
        res.send(audioBuffer);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
router.post('/summary_translation', async (req, res) => {
    const translationRepository = new TranslationRepository();

    const { text } = req.body;

    if (typeof text !== 'string' || text.trim().length === 0) {
        return res.status(400).json({
            error: 'Invalid input: text must be a non-empty string',
        });
    }
    try {
        const translation = await translationRepository.performTranslation(
            text
        );

        res.json(translation);
    } catch (error) {
        console.error('Error in /summary_translation:', error);
        res.status(500).json({ error: error.message });
    }
});

router.post('/chat', async (req, res) => {
    const chatRepository = new ChatRepository();

    const { message, context } = req.body;

    if (!message) {
        return res.status(400).json({
            error: 'Message is required.',
        });
    }

    try {
        if (context === undefined) {
            console.warn('Context is undefined, using empty string');
        }

        const response = await chatRepository.performChat(
            message,
            context || ''
        );

        res.json({ response });
    } catch (error) {
        console.error('Error in /chat:', error);
        console.error('Error stack:', error.stack);
        res.status(500).json({ error: error.message, stack: error.stack });
    }
});
export default router;
