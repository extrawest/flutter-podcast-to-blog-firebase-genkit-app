import 'dotenv/config';
export class ImageRepository {
    constructor() {}

    async performTextToImage(text) {
        if (!text || typeof text !== 'string') {
            throw new Error('Invalid input: text must be a non-empty string');
        }
        const url = 'https://imagegenerationflow-b74e5wflra-uc.a.run.app';

        try {
            console.log('Generating image for text:', text);
            const response = await fetch(url, {
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
                console.error('Error response body:', errorBody);
                throw new Error(
                    `HTTP error! status: ${response.status}, body: ${errorBody}`
                );
            }

            const result = await response.json();
            console.log('Raw cloud function result:', result);

            if (result && result.result && result.result.imageUrl) {
                console.info('Image generation completed successfully');
                // Extract the base64 data from the data URL
                const base64Data = result.result.imageUrl.split(',')[1];
                return base64Data;
            } else {
                console.error('Unexpected response format:', result);
                throw new Error(
                    'Unexpected response format from cloud function'
                );
            }
        } catch (error) {
            console.error('Error during text-to-image generation:', error);
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
            console.error('Error converting Blob to Base64:', error);
            throw new Error(
                'Blob to Base64 conversion failed: ' + error.message
            );
        }
    }
}

export default new ImageRepository();
