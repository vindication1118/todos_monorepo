import { useAuth } from '../auth/AuthContext';

export const fetchWithAuth = async (
  url: string,
  method: string = 'GET',
  body?: any
) => {
  const token = localStorage.getItem('token');
  return fetch(url, {
    method,
    headers: {
      'Content-Type': 'application/json',
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    },
    ...(body ? { body: JSON.stringify(body) } : {}),
  }).then((res) => {
    if (!res.ok) throw new Error(`Failed fetch: ${res.status}`);
    return res.json();
  });
};
