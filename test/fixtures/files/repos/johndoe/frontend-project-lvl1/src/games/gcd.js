import engine from '../index.js';
import getRandom from '../helpers/getRandom.js';

/**
 * Euclid GCD
 * calculate the greatest common divisor
 *
 * @param {number} min fewer value
 * @param {number} max more value
 * @return {number} greatest common factor of @param min and @param max
 */
const getGcd = (min, max) => {
  const diff = max % min;
  if (diff === 0) return min;

  return getGcd(diff, min);
};

/**
 * Game description
 *
 * @constant {string}
 */
const description = 'Find the greatest common divisor of given numbers.';

/**
 * Brain GCD
 * the user must calculate the greatest common divisor
 * of two numbers
 *
 * @param {number} range rande of valid values of numbers from 0
 *
 * @returns {Object} next round game state
 * @returns {string} round condition: two random numbers
 * @returns {string} round expected answer: greatest common divisor of these numbers
 */
const generateRound = (range = 100) => {
  const num1 = getRandom(range, 1);
  const num2 = getRandom(range, 1);
  const [min, max] = [num1, num2].sort();

  return {
    question: `${num1} ${num2}`,
    expectedAnswer: getGcd(min, max).toString(),
  };
};

export default engine(
  generateRound,
  description,
);
