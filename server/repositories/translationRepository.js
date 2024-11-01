import 'dotenv/config';
import constants from '../consts.js';

export class TranslationRepository {
    constructor() {}

    async performTranslation(text) {
        if (typeof text !== 'string') {
            throw new Error('Input text must be a string');
        }
        try {
            const response = await fetch(constants.TRANSLATION_URL, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    data: text,
                }),
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const result = await response.json();
            if (result && result.result) {
                return result.result;
            } else {
                throw new Error(
                    'Unexpected response format from cloud function'
                );
            }
        } catch (error) {
            throw new Error(
                'Cloud function summarization failed: ' + error.message
            );
        }
    }
}
export default new TranslationRepository();
