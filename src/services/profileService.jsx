import axios from 'axios';

const USER_API_URL = 'http://localhost:8080/api/v1/user';

// Create a simple axios instance without auth interceptors
const axiosInstance = axios.create();

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

export const getProfileAPI = async () => {
  try {
    const response = await axiosInstance.get(`${USER_API_URL}/profile`,{
      headers: {
        'Content-Type': 'application/json'
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

export const updateProfileAPI = async (profileData) => {
  try {
    const formData = new FormData();
    
    const profileUpdateDTO = {
      Fullname: profileData.fullName,
      address: profileData.address,
      gender: profileData.gender,
      Dob: profileData.dateOfBirth,
      phoneNumber: profileData.phoneNumber,
      email: profileData.email
    };

    formData.append('user', new Blob([JSON.stringify(profileUpdateDTO)], {
      type: 'application/json'
    }));

    if (profileData.avatar) {
      formData.append('avatar', profileData.avatar);
    }

    const response = await axiosInstance.put(`${USER_API_URL}/profile`, formData, {
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