import engine from '../index.js';
import getRandom from '../helpers/getRandom.js';

/**
 * An objects that contains the signed string of the operatioin as key
 * and a function to calculate the operation as a value
 *
 * @constant {Object}
 */
const calcMap = {
  '+': (num1, num2) => num1 + num2,
  '-': (num1, num2) => num1 - num2,
  '*': (num1, num2) => num1 * num2,
};

/**
 * Returns array of calcMap keys
 *
 * @return {array}
 */
const operations = Object.keys(calcMap);

/**
 * Returned calculation result
 *
 * @param {number} num1 first number
 * @param {number} num2 second number
 * @param {string} operation calculation operation sign
 *
 * @return {number} calculation result
 */
const getAnswer = (num1, num2, operation) => (
  calcMap[operation](num1, num2)
);

/**
 * Game description
 *
 * @constant {string}
 */
const description = 'What is the result of the expression?';

/**
 * Brain Calc
 * the user must solve the expression
 *
 * @param {number} range rande of valid values of numbers from 0
 *
 * @returns {Object} next round game state
 * @returns {string} round condition: mathematical expression
 * @returns {string} round expected answer: the result of evaluating an expression
 */
const generateRound = (range = 100) => {
  const operationIndex = getRandom(operations.length - 1);
  const operation = operations[operationIndex];
  const num1 = getRandom(range);
  const num2 = getRandom(range);

  return {
    question: `${num1} ${operation} ${num2}`,
    expectedAnswer: getAnswer(num1, num2, operation).toString(),
  };
};

export default engine(
  generateRound,
  description,
);
