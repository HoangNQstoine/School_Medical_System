import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import NurseLayout from '../../components/Layout/NurseLayout';
import { GetCurrentUserAPI } from '../../services/authService';
import { format, isValid, parseISO } from 'date-fns';

const NurseDashboard = () => {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [nurseData, setNurseData] = useState(null);

  useEffect(() => {
    const fetchNurseData = async () => {
      try {
        setLoading(true);
        const response = await GetCurrentUserAPI();
        setNurseData(response.data);
        setError(null);
      } catch (err) {
        setError('Failed to load nurse data. Please try again later.');
        console.error('Error fetching nurse data:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchNurseData();
  }, []);

  // Helper function to format dates safely
  const formatDate = (dateString) => {
    if (!dateString) return 'No date';
    const date = parseISO(dateString);
    return isValid(date) ? format(date, 'MMM dd, yyyy') : 'Invalid date';
  };

  if (loading) {
    return (
      <NurseLayout>
        <div className="flex items-center justify-center min-h-[400px]">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-teal-600"></div>
        </div>
      </NurseLayout>
    );
  }

  if (error) {
    return (
      <NurseLayout>
        <div className="text-center text-red-600 p-4">
          <p>{error}</p>
          <button
            onClick={() => window.location.reload()}
            className="mt-4 px-4 py-2 bg-teal-600 text-white rounded-lg hover:bg-teal-700 transition-colors"
          >
            Retry
          </button>
        </div>
      </NurseLayout>
    );
  }

  const dashboardStats = [
    {
      label: 'Total Students',
      value: '1,234',
      icon: (
        <svg className="w-8 h-8 text-teal-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
        </svg>
      ),
    },
    {
      label: 'Today\'s Appointments',
      value: '15',
      icon: (
        <svg className="w-8 h-8 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
        </svg>
      ),
    },
    {
      label: 'Pending Reports',
      value: '7',
      icon: (
        <svg className="w-8 h-8 text-yellow-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
        </svg>
      ),
    },
    {
      label: 'Medicine Alerts',
      value: '3',
      icon: (
        <svg className="w-8 h-8 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
        </svg>
      ),
    },
  ];

  const upcomingAppointments = [
    {
      studentName: 'John Doe',
      time: '09:00 AM',
      date: '2024-03-01',
      type: 'Regular Checkup',
      status: 'Confirmed',
    },
    {
      studentName: 'Jane Smith',
      time: '10:30 AM',
      date: '2024-03-01',
      type: 'Vaccination',
      status: 'Pending',
    },
    {
      studentName: 'Mike Johnson',
      time: '11:45 AM',
      date: '2024-03-01',
      type: 'Follow-up',
      status: 'Confirmed',
    },
  ];

  const recentPatients = [
    {
      name: 'Alice Brown',
      class: '10A',
      lastVisit: '2024-02-28',
      condition: 'Fever',
      status: 'Recovering',
    },
    {
      name: 'Bob Wilson',
      class: '11B',
      lastVisit: '2024-02-27',
      condition: 'Sprained Ankle',
      status: 'Treated',
    },
    {
      name: 'Carol Martinez',
      class: '9C',
      lastVisit: '2024-02-26',
      condition: 'Headache',
      status: 'Recovered',
    },
  ];

  return (
    <NurseLayout>
      <div className="space-y-8">
        {/* Dashboard Stats */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {dashboardStats.map((stat, index) => (
            <div
              key={index}
              className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 flex items-center space-x-4"
            >
              {stat.icon}
              <div>
                <p className="text-sm text-gray-500">{stat.label}</p>
                <p className="text-lg font-semibold text-gray-900">{stat.value}</p>
              </div>
            </div>
          ))}
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* Upcoming Appointments */}
          <div>
            <h2 className="text-xl font-semibold text-gray-900 mb-4">Today's Appointments</h2>
            <div className="bg-white rounded-xl shadow-sm border border-gray-100">
              <div className="divide-y divide-gray-100">
                {upcomingAppointments.map((appointment, index) => (
                  <div key={index} className="p-4">
                    <div className="flex items-center justify-between">
                      <div>
                        <p className="font-medium text-gray-900">{appointment.studentName}</p>
                        <p className="text-sm text-gray-500">{appointment.type}</p>
                        <p className="text-sm text-gray-500">{appointment.time}</p>
                      </div>
                      <div className="text-right">
                        <span
                          className={`inline-block px-2 py-1 text-xs rounded-full ${
                            appointment.status === 'Confirmed'
                              ? 'bg-green-100 text-green-800'
                              : 'bg-yellow-100 text-yellow-800'
                          }`}
                        >
                          {appointment.status}
                        </span>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
              <div className="p-4 border-t">
                <Link
                  to="/Nurse/appointments"
                  className="text-teal-600 hover:text-teal-700 font-medium text-sm"
                >
                  View all appointments →
                </Link>
              </div>
            </div>
          </div>

          {/* Recent Patients */}
          <div>
            <h2 className="text-xl font-semibold text-gray-900 mb-4">Recent Patients</h2>
            <div className="bg-white rounded-xl shadow-sm border border-gray-100">
              <div className="divide-y divide-gray-100">
                {recentPatients.map((patient, index) => (
                  <div key={index} className="p-4">
                    <div className="flex items-center justify-between">
                      <div>
                        <p className="font-medium text-gray-900">{patient.name}</p>
                        <p className="text-sm text-gray-500">Class: {patient.class}</p>
                        <p className="text-sm text-gray-500">
                          Last Visit: {formatDate(patient.lastVisit)}
                        </p>
                      </div>
                      <div className="text-right">
                        <p className="text-sm text-gray-500">{patient.condition}</p>
                        <span
                          className={`inline-block px-2 py-1 text-xs rounded-full ${
                            patient.status === 'Recovered'
                              ? 'bg-green-100 text-green-800'
                              : patient.status === 'Recovering'
                              ? 'bg-yellow-100 text-yellow-800'
                              : 'bg-blue-100 text-blue-800'
                          }`}
                        >
                          {patient.status}
                        </span>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
              <div className="p-4 border-t">
                <Link
                  to="/Nurse/patient-records"
                  className="text-teal-600 hover:text-teal-700 font-medium text-sm"
                >
                  View all patients →
                </Link>
              </div>
            </div>
          </div>
        </div>

        {/* Quick Actions */}
        <div>
          <h2 className="text-xl font-semibold text-gray-900 mb-4">Quick Actions</h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <Link
              to="/Nurse/appointments/new"
              className="bg-white p-4 rounded-lg shadow-sm border border-gray-100 hover:border-teal-500 transition-colors group"
            >
              <div className="flex items-center space-x-3">
                <div className="flex-shrink-0 w-10 h-10 bg-teal-100 text-teal-600 rounded-lg flex items-center justify-center group-hover:bg-teal-600 group-hover:text-white transition-colors">
                  <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 4v16m8-8H4" />
                  </svg>
                </div>
                <span className="font-medium text-gray-900">New Appointment</span>
              </div>
            </Link>
            <Link
              to="/Nurse/inventory"
              className="bg-white p-4 rounded-lg shadow-sm border border-gray-100 hover:border-teal-500 transition-colors group"
            >
              <div className="flex items-center space-x-3">
                <div className="flex-shrink-0 w-10 h-10 bg-teal-100 text-teal-600 rounded-lg flex items-center justify-center group-hover:bg-teal-600 group-hover:text-white transition-colors">
                  <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
                  </svg>
                </div>
                <span className="font-medium text-gray-900">Check Inventory</span>
              </div>
            </Link>
            <Link
              to="/Nurse/student-chat"
              className="bg-white p-4 rounded-lg shadow-sm border border-gray-100 hover:border-teal-500 transition-colors group"
            >
              <div className="flex items-center space-x-3">
                <div className="flex-shrink-0 w-10 h-10 bg-teal-100 text-teal-600 rounded-lg flex items-center justify-center group-hover:bg-teal-600 group-hover:text-white transition-colors">
                  <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M8 10h.01M12 10h.01M16 10h.01M9 16H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-5l-5 5v-5z" />
                  </svg>
                </div>
                <span className="font-medium text-gray-900">Student Messages</span>
              </div>
            </Link>
          </div>
        </div>
      </div>
    </NurseLayout>
  );
};

export default NurseDashboard; 