import React from 'react';
import ParentLayout from '../../components/Layout/ParentLayout';
import UpdateProfileForm from '../../components/Profile/UpdateProfileForm';

const Settings = () => {
  return (
    <ParentLayout>
      <div className="space-y-6">
        {/* Profile Section */}
        <div className="bg-white rounded-lg shadow-sm border border-gray-100 p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Profile Settings</h2>
          <p className="text-gray-600 mb-6">
            Update your personal information and profile picture.
          </p>
          <UpdateProfileForm />
        </div>

        {/* Other Settings Sections can be added here */}
      </div>
    </ParentLayout>
  );
};

export default Settings; 