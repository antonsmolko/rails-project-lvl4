import engine from '../index.js';
import getRandom from '../helpers/getRandom.js';

/**
 * Returns a random arithmetic progression
 *
 * @param {number} start a number at which the arithmetic progression starts
 * @param {number} step a value of arithmetic progression step
 * @param {number} length a value of arithmetic progression length
 *
 * @return {array} an array whose values a numbers forming an arithmetic progression
 */
const generateProgression = (start, step, length) => {
  const result = [];
  for (let i = 0; i < length; i += 1) {
    const next = i === 0 ? start : result[i - 1] + step;
    result.push(next);
  }

  return result;
};

/**
 * Game description
 *
 * @constant {string}
 */
const description = 'What number is missing in the progression?';

/**
 * Number of element in arithmetic progression
 *
 * @const {number}
 */
const progressionLength = 10;

/**
 * Brain Progression
 * the user has to calculate the missing value
 * of the arithmetic progression
 *
 * @returns {Object} next round game state
 * @returns {string} round condition: arithmetic progression with random hidden element
 * @returns {string} round expected answer: value of hidden element
 */
const generateRound = () => {
  const start = getRandom(30);
  const step = getRandom(20, 3);

  const progression = generateProgression(start, step, progressionLength);
  const hiddenIndex = getRandom(progressionLength - 1);
  const expectedAnswer = progression
    .splice(hiddenIndex, 1, '..')
    .toString();

  return {
    question: progression.join(' '),
    expectedAnswer,
  };
};

export default engine(
  generateRound,
  description,
);
