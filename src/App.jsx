import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Login from './pages/login';
import Signup from './pages/signup';
import Parent from './pages/Parent/parent';
import HealthRecords from './pages/Parent/HealthRecords';
import Appointments from './pages/Parent/Appointments';
import Messages from './pages/Parent/Messages';
import Settings from './pages/Parent/Settings';
import Student from './pages/Student/student';
import Nurse from './pages/Nurse/nurse';

function App() {
  return (
    <Router>
      <div className="bg-gray-50 min-h-screen">
        <Routes>
          {/* Auth Routes */}
          <Route path="/login" element={<Login />} />
          <Route path="/signup" element={<Signup />} />

          {/* Parent Routes */}
          <Route path="/parent" element={<Parent />} />
          <Route path="/parent/health-records" element={<HealthRecords />} />
          <Route path="/parent/appointments" element={<Appointments />} />
          <Route path="/parent/messages" element={<Messages />} />
          <Route path="/parent/settings" element={<Settings />} />

          {/* Student Routes */}
          <Route path="/student" element={<Student />} />

          {/* Nurse Routes */}
          <Route path="/nurse" element={<Nurse />} />

          {/* Default Route */}
          <Route path="/" element={<Navigate to="/login" replace />} />
          <Route path="*" element={<Navigate to="/login" replace />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
