import PodcastIndexClient from 'podcastdx-client';

export class PodcastIndexRepository {
    constructor({ apiKey, apiSecret }) {
        this.apiKey = apiKey;
        this.apiSecret = apiSecret;
        this.client = null;
        this.initClient();
    }

    initClient() {
        if (!this.apiKey || !this.apiSecret) {
            console.error('Podcast Index API key or secret is missing');
            return false;
        }

        try {
            this.client = new PodcastIndexClient({
                key: this.apiKey,
                secret: this.apiSecret,
                disableAnalytics: true,
            });
            return true;
        } catch (error) {
            console.error('Failed to initialize Podcast Index client:', error);
            return false;
        }
    }

    async performPodcastSearch({ searchTerm, limit, offset }) {
        if (!this.client) {
            throw new Error('Podcast Index client is not initialized');
        }
        console.log('searchTerm>>:', searchTerm);
        const result = await this.client.episodesByItunesId(searchTerm, {
            max: 10,
        });
        return result;
    }

    async performEpisodesByIdSearch(searchId) {
        if (!this.client) {
            throw new Error('Podcast Index client is not initialized');
        }
        const result = await this.client.episodeById(searchId);
        return result;
    }
}
