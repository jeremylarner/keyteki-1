const Card = require('../../Card.js');

class MackTheKnife extends Card {
    setupCardAbilities(ability) {
        this.persistentEffect({
            effect: ability.effects.canUse(card => card === this)
        });

        this.action({
            target: {
                cardType: 'creature',
                gameAction: ability.actions.dealDamage()
            },
            then: {
                condition: context => context.preThenEvent.destroyed,
                gameAction: ability.actions.gainAmber()
            }
        });
    }
}

MackTheKnife.id = 'mack-the-knife'; // This is a guess at what the id might be - please check it!!!

module.exports = MackTheKnife;
