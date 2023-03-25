import axios from 'axios';

// const instance = axios.create({
// 	baseURL: 'https://127.0.0.1:8000',
// 	timeout: 1000,
// 	headers: {'Content-type': 'application/json; charset=UTF-8'}
// });

const instance = {
	baseURL: 'https://localhost:8000',
    AWS_URL: 'https://comicsmore.s3.eu-west-3.amazonaws.com',
    frontURL: 'http://localhost:5173'
};

// const instance = 'https://127.0.0.1:8000';
// const AWS_URL = 'https://comicsmore.s3.eu-west-3.amazonaws.com';

export default instance;