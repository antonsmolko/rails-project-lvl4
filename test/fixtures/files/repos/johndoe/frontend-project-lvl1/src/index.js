import promptly from 'promptly';

/**
 * Number of game rounds
 * @constant {number}
 */
const roundsCount = 3;

/**
 * Game engine
 *
 * @param {Object} options
 * @param {function} options.generateRound function with logic of the specific engine
 * @param {string} options.descriptions game rule description
 */
export default (generateRound, descriptions) => async () => {
  try {
    const name = await promptly.prompt('May I have your name?');
    console.log(`Hello, ${name}!`);
    console.log(descriptions);

    for (let i = 1; i <= roundsCount; i += 1) {
      const { question, expectedAnswer } = generateRound();
      // eslint-disable-next-line no-await-in-loop
      const userAnswer = await promptly.prompt(`Question: ${question}`);
      console.log('You answer:', userAnswer);

      if (userAnswer === expectedAnswer) {
        console.log('Correct!');
      } else {
        console.log(`"${userAnswer}" is wrong answer ;(. Correct answer was "${expectedAnswer}".`);
        console.log(`Let's try again, ${name}!`);
        return;
      }
    }

    console.log(`Congratulations, ${name}!`);
  } catch (error) {
    console.log('exit');
  }
};
