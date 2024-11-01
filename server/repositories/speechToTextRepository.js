import axios from 'axios';
import 'dotenv/config';
import { HuggingFaceRepository } from './huggingFaceRepository.js';
import fs from 'fs';
import path from 'path';

export class SpeechToTextRepository {
    constructor(huggingFaceRepository) {
        if (!(huggingFaceRepository instanceof HuggingFaceRepository)) {
            throw new Error('Invalid HuggingFaceRepository instance');
        }
        this.hfClient = null;
        this.huggingFaceRepository = huggingFaceRepository;
        this.isInitialized = false;
    }

    async init() {
        if (this.isInitialized) {
            console.warn('SpeechToTextRepository is already initialized');
            return;
        }

        try {
            this.hfClient = this.huggingFaceRepository.getClient();
            this.isInitialized = true;
            console.log('SpeechToTextRepository initialized successfully');
        } catch (error) {
            console.error(
                'Failed to initialize Hugging Face repository:',
                error
            );
            throw new Error('Initialization error: ' + error.message);
        }
    }

    async fetchAudioData(fileUrl) {
        try {
            const response = await axios({
                url: fileUrl,
                method: 'GET',
                responseType: 'arraybuffer',
            });
            return response.data;
        } catch (error) {
            console.error('Error fetching audio data:', error);
            throw new Error('Failed to fetch audio data: ' + error.message);
        }
    }

    async readFileChunk(filePath, start, end) {
        return new Promise((resolve, reject) => {
            const stream = fs.createReadStream(filePath, { start, end });
            const chunks = [];
            stream.on('data', (chunk) => chunks.push(chunk));
            stream.on('end', () => resolve(Buffer.concat(chunks)));
            stream.on('error', reject);
        });
    }

    async transcribeChunk(audioChunk) {
        if (!this.isInitialized) {
            throw new Error(
                'SpeechToTextRepository is not initialized. Call init() first.'
            );
        }

        try {
            const speechToTextResult =
                await this.hfClient.automaticSpeechRecognition({
                    model: 'openai/whisper-large-v3-turbo',
                    data: audioChunk,
                });

            if (
                typeof speechToTextResult === 'object' &&
                speechToTextResult.text
            ) {
                return speechToTextResult.text;
            } else if (typeof speechToTextResult === 'string') {
                return speechToTextResult;
            } else {
                throw new Error('Unexpected speech-to-text result format');
            }
        } catch (error) {
            console.error('Error transcribing chunk:', error);
            throw new Error('Transcription failed: ' + error.message);
        }
    }

    async performSpeechToText(filePath, chunkSize = 1 * 1024 * 1024) {
        if (!this.isInitialized) {
            throw new Error(
                'SpeechToTextRepository is not initialized. Call init() first.'
            );
        }

        try {
            console.log('filePath:', filePath);
            const fileSize = fs.statSync(filePath).size;
            const chunks = Math.ceil(fileSize / chunkSize);
            let fullTranscription = '';

            for (let i = 0; i < chunks; i++) {
                const start = i * chunkSize;
                const end = Math.min((i + 1) * chunkSize - 1, fileSize - 1);

                const audioChunk = await this.readFileChunk(
                    filePath,
                    start,
                    end
                );
                const chunkTranscription = await this.transcribeChunk(
                    audioChunk
                );
                fullTranscription += chunkTranscription + ' ';
            }

            return fullTranscription.trim();
        } catch (error) {
            console.error('Error in performSpeechToText:', error);
            throw new Error(
                'Speech to text conversion failed: ' + error.message
            );
        }
    }

    async performDownloadFile(url) {
        try {
            const localFilePath = path.resolve(
                './uploads',
                'podcast_episode.mp3'
            );
            const writer = fs.createWriteStream(localFilePath);
            const response = await axios({
                url,
                method: 'GET',
                responseType: 'stream',
            });

            response.data.pipe(writer);

            return new Promise((resolve, reject) => {
                writer.on('finish', () => resolve(localFilePath));
                writer.on('error', reject);
            });
        } catch (error) {
            console.error('Error downloading file:', error);
            throw new Error('File download failed: ' + error.message);
        }
    }

    isReady() {
        return this.isInitialized;
    }

    reset() {
        this.hfClient = null;
        this.isInitialized = false;
        console.log('SpeechToTextRepository reset');
    }
}

// Create and export a default instance
const defaultHuggingFaceRepository = new HuggingFaceRepository(
    process.env.HF_KEY || ''
);
export default new SpeechToTextRepository(defaultHuggingFaceRepository);
