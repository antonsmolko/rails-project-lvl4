import engine from '../index.js';
import getRandom from '../helpers/getRandom.js';

/**
 * Determines whether a number is prime
 *
 * @param {number} number
 *
 * @return {boolean}
 */
const isPrime = (number) => {
  if (number < 2) return false;
  if (number % 2 === 0) return number === 2;
  if (number % 3 === 0) return number === 3;

  for (let i = 5; i * i <= number; i += 6) {
    if (number % i === 0 || number % (i + 2) === 0) return false;
  }

  return true;
};

/**
 * Game description
 *
 * @constant {string}
 */
const description = 'Answer "yes" if given number is prime. Otherwise answer "no".';

/**
 * Brain Prime
 * the user must determine if the number is prime
 *
 * @param {number} range rande of valid values of numbers from 0
 *
 * @returns {Object} next round game state
 * @returns {number} round condition: random number
 * @returns {string} round expected answer: 'yes', 'no'
 */
const generateRound = (range = 100) => {
  const number = getRandom(range, 2);

  return {
    question: number,
    expectedAnswer: isPrime(number) ? 'yes' : 'no',
  };
};

export default engine(
  generateRound,
  description,
);
