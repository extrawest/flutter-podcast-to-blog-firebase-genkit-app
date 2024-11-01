import PodcastIndexClient from 'podcastdx-client';

export async function initPodcastIndexClient() {
    const client = new PodcastIndexClient({
        key: process.env.PODCAST_INDEX_API_KEY,
        secret: process.env.PODCAST_INDEX_API_SECRET,
        disableAnalytics: true,
    });

    return client;
}
