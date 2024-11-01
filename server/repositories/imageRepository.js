import 'dotenv/config';
import constants from '../consts.js';

export class ImageRepository {
    constructor() {}

    async performTextToImage(text) {
        if (!text || typeof text !== 'string') {
            throw new Error('Invalid input: text must be a non-empty string');
        }
        try {
            const response = await fetch(constants.IMAGE_URL, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    data: text,
                }),
            });

            if (!response.ok) {
                const errorBody = await response.text();
                throw new Error(
                    `HTTP error! status: ${response.status}, body: ${errorBody}`
                );
            }

            const result = await response.json();

            if (result && result.result && result.result.imageUrl) {
                // Extract the base64 data from the data URL
                const base64Data = result.result.imageUrl.split(',')[1];
                return base64Data;
            } else {
                throw new Error(
                    'Unexpected response format from cloud function'
                );
            }
        } catch (error) {
            if (error.cause) console.error('Cause:', error.cause);
            throw new Error('Image generation failed: ' + error.message);
        }
    }

    async blobToBase64(blob) {
        if (!(blob instanceof Blob)) {
            throw new Error('Invalid input: expected Blob instance');
        }

        try {
            const arrayBuffer = await blob.arrayBuffer();
            const buffer = Buffer.from(arrayBuffer);
            return buffer.toString('base64');
        } catch (error) {
            throw new Error(
                'Blob to Base64 conversion failed: ' + error.message
            );
        }
    }
}

export default new ImageRepository();
