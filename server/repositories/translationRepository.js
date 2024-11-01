import 'dotenv/config';
export class TranslationRepository {
    constructor() {}

    async performTranslation(text) {
        if (typeof text !== 'string') {
            throw new Error('Input text must be a string');
        }

        const url = 'https://translationflow-b74e5wflra-uc.a.run.app';

        try {
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
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const result = await response.json();
            console.log('Raw cloud function result:', result.result);
            if (result && result.result) {
                return result.result;
            } else {
                throw new Error(
                    'Unexpected response format from cloud function'
                );
            }
        } catch (error) {
            console.error('Error calling summarize cloud function:', error);
            throw new Error(
                'Cloud function summarization failed: ' + error.message
            );
        }
    }
}
export default new TranslationRepository();
