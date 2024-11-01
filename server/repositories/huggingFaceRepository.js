import { HfInference } from '@huggingface/inference';

export class HuggingFaceRepository {
    constructor(apiKey) {
        if (!apiKey) {
            throw new Error(
                'Hugging Face API key is missing. Please set HF_KEY in environment variables.'
            );
        }
        this.hfClient = new HfInference(apiKey);
    }

    getClient() {
        return this.hfClient;
    }
}

export function initHuggingFaceRepository(apiKey) {
    return new HuggingFaceRepository(apiKey);
}
