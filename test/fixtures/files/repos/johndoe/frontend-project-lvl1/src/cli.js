import promptly from 'promptly';

export default async () => {
  console.log('Welcome to the Brain Games!');
  const answer = await promptly.prompt('May I have your name?');
  console.log('Hello,', answer);
};
