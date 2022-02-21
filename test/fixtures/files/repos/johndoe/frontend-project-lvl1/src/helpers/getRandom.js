/**
 * Returns a random number in a given range
 *
 * @param {numver} range max valid value of number
 * @param {number} min min valid value of number
 *
 * @return {number} random number
 */
export default (range, min = 0) => (
  Math.round(Math.random() * (range - min) + min)
);
