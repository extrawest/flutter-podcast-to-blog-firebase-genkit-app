// repositoryManager.js
import { HuggingFaceRepository } from './huggingFaceRepository.js';
import { ElevenLabsRepository } from './elevenLabsRepository.js';

import { PodcastIndexRepository } from './podcastIndexRepository.js';
class RepositoryManager {
    constructor() {
        this.hf = new HuggingFaceRepository(process.env.HF_KEY || '');
        this.elevenLabs = new ElevenLabsRepository(
            process.env.ELEVANLABS_KEY || ''
        );
        this.podcastIndex = new PodcastIndexRepository({
            apiKey: process.env.PODCAST_INDEX_API_KEY || '',
            apiSecret: process.env.PODCAST_INDEX_API_SECRET || '',
        });
    }

    getHuggingFaceRepository() {
        return this.hf;
    }

    getElevenLabsRepository() {
        return this.elevenLabs;
    }
    getPodcastIndexRepository() {
        return this.podcastIndex;
    }
}

const repositoryManager = new RepositoryManager();
export default repositoryManager;
