import React from "react";
import { Link } from 'react-router-dom';
import Header from "../components/navbar"
import LoginSignupImg from '../assets/LoginSignupImg.png';

const Login = () => {
  return (
        <div className="flex flex-1 items-center justify-center p-8">
          <div className="hidden lg:block w-1/2 pr-8">
            <img src={LoginSignupImg} alt="Login or Signup" className="rounded-2xl shadow-lg w-full h-auto" />
          </div>
          <div className="w-full max-w-md bg-white p-8 rounded-lg shadow-lg">
            
            <h2 className="text-2xl font-bold text-center mb-6">Login</h2>
            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700">E-mail</label>
                <input
                  type="email"
                  className="mt-1 w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  placeholder="E-mail"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700">Password</label>
                <div className="relative">
                  <input
                    type="password"
                    className="mt-1 w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                    placeholder="Password"
                  />
                  <a href="#" className="absolute right-3 top-4 text-blue-600 text-sm hover:underline">Forget password?</a>
                </div>
              </div>
              <div className="flex justify-between items-center">
                <label className="flex items-center">
                  <input type="checkbox" className="mr-2" />
                  <span className="text-sm text-gray-600">Remember Me</span>
                </label>
                <label className="flex items-center">
                  <input type="checkbox" className="mr-2" />
                  <span className="text-sm text-gray-600">Login with OTP</span>
                </label>
              </div>
              <button className="w-full bg-blue-500 text-white py-3 rounded-lg hover:bg-blue-600 transition duration-200">
                Sign In
              </button>
            </div>
            <div className="mt-6 text-center">
              <p className="text-sm text-gray-600">or</p>
              <button className="w-full mt-4 bg-white border border-gray-300 text-gray-700 py-3 rounded-lg hover:bg-gray-50 flex items-center justify-center space-x-2">
                <img src="https://www.google.com/favicon.ico" alt="Google" className="w-5 h-5" />
                <span>Sign in With Google</span>
              </button>
            </div>
            <p className="text-center text-sm text-gray-600 mt-8">
              Don&apos;t have an account?{' '}
              <Link to="/signup" className="text-blue-500 font-medium hover:underline">Sign up</Link>
            </p>
          </div>
        </div>
  )
}

export default Login