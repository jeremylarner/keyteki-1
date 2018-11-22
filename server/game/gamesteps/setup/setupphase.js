const _ = require('underscore');
const Phase = require('../phase.js');
const SimpleStep = require('../simplestep.js');
const MulliganPrompt = require('./mulliganprompt.js');
const Effects = require('../../effects.js');

class SetupPhase extends Phase {
    constructor(game) {
        super(game, 'setup');
        this.initialise([
            new SimpleStep(game, () => this.setupBegin()),
            new SimpleStep(game, () => this.chooseFirstPlayer()),
            new SimpleStep(game, () => this.firstPlayerEffects()),
            new SimpleStep(game, () => this.drawStartingHands()),
            new MulliganPrompt(game),
            new SimpleStep(game, () => this.startGame())
        ]);
    }

    startPhase() {
        // Don't raise any events without a determined first player
        this.game.currentPhase = this.name;
        for(let step of this.steps) {
            this.game.queueStep(step);
        }
    }

    setupBegin() {
        let allPlayersShuffled = _.shuffle(this.game.getPlayers());
        this.game.activePlayer = allPlayersShuffled.shift();
        for(let card of this.game.allCards) {
            card.applyAnyLocationPersistentEffects();
        }
    }

    chooseFirstPlayer() {
        if(this.game.activePlayer.opponent) {
            this.game.promptWithHandlerMenu(this.game.activePlayer, {
                activePromptTitle: 'You won the flip. Do you want to be:',
                source: 'Choose First Player',
                choices: ['First Player', 'Second Player'],
                handlers: [
                    () => true,
                    () => this.game.activePlayer = this.game.activePlayer.opponent
                ]
            });
        }
    }

    firstPlayerEffects() {
        this.game.activePlayer.drawCardsToHand(1);
        this.game.actions.forRemainderOfTurn({
            condition: () => !!this.game.cardsUsed.length || !!this.game.cardsPlayed.length || !!this.game.cardsDiscarded.length,
            effect: [
                Effects.playerCannot('play', context => context.ability.isAction() && !context.ignoreHouse),
                Effects.playerCannot('discard', context => context.ability.isAction() && !context.ignoreHouse)
            ]
        }).resolve(this.game.activePlayer, this.game.getFrameworkContext());
    }

    drawStartingHands() {
        _.each(this.game.getPlayers(), player => {
            player.drawCardsToHand(player.maxHandSize);
            if(player.chains > 0) {
                player.modifyChains(-1);
                this.game.addMessage('{0}\'s chains are reduced by 1 to {1}', player, player.chains);
            }
        });
    }

    startGame() {
        _.each(this.game.getPlayers(), player => {
            player.readyToStart = true;
        });
    }
}

module.exports = SetupPhase;
