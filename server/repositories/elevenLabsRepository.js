import { ElevenLabsClient } from 'elevenlabs';

export class ElevenLabsRepository {
    constructor(apiKey) {
        this.client = new ElevenLabsClient({
            // apiKey: apiKey,
            apiKey: process.env.ELEVANLABS_KEY,
        });
    }

    getClient() {
        return this.client;
    }
}

export function initElevenLabsRepository(apiKey) {
    return new ElevenLabsRepository(apiKey);
}
