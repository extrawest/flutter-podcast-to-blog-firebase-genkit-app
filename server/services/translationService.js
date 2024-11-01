import translationRepository from '../repositories/translationRepository.js';
import 'dotenv/config';

class TranslationService {
    constructor() {
        this.repository = translationRepository;
    }

    async translateText(text) {
        await this.repository.init();

        const translation = await this.repository.performTranslation(text);
        console.log('translated text:', text);
        return translation;
    }
}

export default new TranslationService();
