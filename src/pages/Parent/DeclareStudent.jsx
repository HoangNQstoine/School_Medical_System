import React, { useState } from 'react';
import ParentLayout from '../../components/Layout/ParentLayout';

const DeclareStudent = () => {
  const [formData, setFormData] = useState({
    studentId: '',
    relationship: 'parent', // Default relationship
    additionalInfo: ''
  });

  const [isLoading, setIsLoading] = useState(false);
  const [message, setMessage] = useState({ type: '', text: '' });

  const relationships = [
    { value: 'parent', label: 'Parent' },
    { value: 'guardian', label: 'Legal Guardian' },
    { value: 'stepparent', label: 'Step Parent' },
    { value: 'grandparent', label: 'Grandparent' },
    { value: 'other', label: 'Other' }
  ];

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
    setMessage({ type: '', text: '' }); // Clear any previous messages
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsLoading(true);
    setMessage({ type: '', text: '' });

    try {
      // TODO: Replace with actual API call
      const response = await fetch('http://localhost:8080/api/v1/parent/declare-student', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData),
        credentials: 'include'
      });

      const data = await response.json();

      if (response.ok) {
        setMessage({
          type: 'success',
          text: 'Student relationship declaration submitted successfully!'
        });
        setFormData({
          studentId: '',
          relationship: 'parent',
          additionalInfo: ''
        });
      } else {
        setMessage({
          type: 'error',
          text: data.message || 'Failed to submit declaration'
        });
      }
    } catch (error) {
      setMessage({
        type: 'error',
        text: 'An error occurred while submitting the declaration'
      });
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <ParentLayout>
      <div className="max-w-2xl mx-auto">
        <div className="bg-white rounded-lg shadow-sm border border-gray-100 p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-6">Declare Student Relationship</h2>
          
          {message.text && (
            <div
              className={`mb-4 p-4 rounded-lg ${
                message.type === 'success'
                  ? 'bg-green-50 text-green-800'
                  : 'bg-red-50 text-red-800'
              }`}
            >
              {message.text}
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-6">
            {/* Student ID Input */}
            <div>
              <label htmlFor="studentId" className="block text-sm font-medium text-gray-700 mb-1">
                Student ID
              </label>
              <input
                type="text"
                id="studentId"
                name="studentId"
                value={formData.studentId}
                onChange={handleChange}
                required
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                placeholder="Enter student ID"
              />
            </div>

            {/* Relationship Selection */}
            <div>
              <label htmlFor="relationship" className="block text-sm font-medium text-gray-700 mb-1">
                Relationship to Student
              </label>
              <select
                id="relationship"
                name="relationship"
                value={formData.relationship}
                onChange={handleChange}
                required
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              >
                {relationships.map(rel => (
                  <option key={rel.value} value={rel.value}>
                    {rel.label}
                  </option>
                ))}
              </select>
            </div>

            {/* Additional Information */}
            <div>
              <label htmlFor="additionalInfo" className="block text-sm font-medium text-gray-700 mb-1">
                Additional Information
              </label>
              <textarea
                id="additionalInfo"
                name="additionalInfo"
                value={formData.additionalInfo}
                onChange={handleChange}
                rows="4"
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                placeholder="Provide any additional information about your relationship with the student"
              />
            </div>

            {/* Submit Button */}
            <div>
              <button
                type="submit"
                disabled={isLoading}
                className={`w-full py-3 px-4 rounded-lg text-white font-medium ${
                  isLoading
                    ? 'bg-blue-400 cursor-not-allowed'
                    : 'bg-blue-600 hover:bg-blue-700'
                } transition-colors`}
              >
                {isLoading ? 'Submitting...' : 'Submit Declaration'}
              </button>
            </div>
          </form>
        </div>
      </div>
    </ParentLayout>
  );
};

export default DeclareStudent; 