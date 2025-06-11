import axios from 'axios';

const API_URL = 'http://localhost:8080/api/v1/auth';
const USER_API_URL = 'http://localhost:8080/api/v1/user';

// Create axios instance with default config
const axiosInstance = axios.create();

// Add a request interceptor to include JWT token
axiosInstance.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Add a response interceptor to handle token expiration
axiosInstance.interceptors.response.use(
  (response) => response,
  async (error) => {
    if (error.response?.status === 401) {
      // Clear token and redirect to login if unauthorized
      localStorage.removeItem('token');
      window.location.href = '/login';
    }
    return Promise.reject(error);
  }
);

const LoginAPI = async (loginData) => {
  try {
    const response = await axiosInstance.post(`${API_URL}/login`, loginData);
    if (response.data.isSuccess && response.data.data?.token) {
      // Store the token
      localStorage.setItem('token', response.data.data.token);
    }
    return response.data;
  } catch (error) {
    if (error.response?.data) {
      return error.response.data;
    }
    throw error;
  }
};

const RegisterAPI = async (userData) => {
  // Create FormData object
  const formData = new FormData();
  
  // Create user data object
  const userRegisterDTO = {
    password: userData.password,
    username: userData.username,
    Fullname: userData.fullName,
    address: userData.address,
    gender: userData.gender,
    Dob: userData.dateOfBirth,
    phoneNumber: userData.phoneNumber,
    email: userData.email
  };

  // Append user data as part of formData
  formData.append('user', new Blob([JSON.stringify(userRegisterDTO)], {
    type: 'application/json'
  }));

  try {
    const response = await axiosInstance.post(`${API_URL}/register`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    });
    return response.data;
  } catch (error) {
    if (error.response?.data) {
      return error.response.data;
    }
    throw error;
  }
};

const GetCurrentUserAPI = async () => {
  try {
    const response = await axiosInstance.get(`${USER_API_URL}/profile`);
    return response.data;
  } catch (error) {
    if (error.response?.data) {
      return error.response.data;
    }
    throw error;
  }
};

const LogoutAPI = () => {
  localStorage.removeItem('token');
  window.location.href = '/login';
};

export { LoginAPI, RegisterAPI, GetCurrentUserAPI, LogoutAPI };