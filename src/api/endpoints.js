const API_ENDPOINTS = {
  AUTH: {
    LOGIN: 'api/v1/auth/login',
    REGISTER: 'api/v1/auth/register',
    FORGOT_PASSWORD: 'api/v1/auth/forgot-password',
    RESET_PASSWORD: 'api/v1/auth/reset-password',
    LOGOUT: 'api/v1/auth/logout',
    VERIFY_EMAIL: 'api/v1/otp/verify',
  },
  USER: {
    PROFILE: '/users/profile',
    UPDATE_PROFILE: '/users/profile',
    CHANGE_PASSWORD: '/users/change-password',
    GET_ALL: 'api/v1/user',
    CREATE: 'api/v1/user',
    GET_BY_ID: (id) => `api/v1/user/${id}`,
    UPDATE: (id) => `api/v1/user/${id}`,
    DELETE: (id) => `api/v1/user/delete/${id}`,
  },
  HEALTH: {
    RECORDS: '/health-records',
    RECORD_DETAIL: (id) => `/health-records/${id}`,
    CREATE_RECORD: '/health-records',
    UPDATE_RECORD: (id) => `/health-records/${id}`,
    DELETE_RECORD: (id) => `/health-records/${id}`,
  },
  MEDICATION_ENDPOINTS: {
    CREATE: 'api/medications',
    GET_ALL: 'api/medications/all',
    UPDATE: (id) => `api/medications/${id}`,
    DELETE: (id) => `api/medications/${id}`,
  },
};

export default API_ENDPOINTS; 