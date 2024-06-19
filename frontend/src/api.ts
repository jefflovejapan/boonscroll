import { Link, FetchError } from './types';


const jsonHeaders = { 'Content-Type': 'application/json' };

export async function loadLinks(): Promise<Link[]> {
    const response = await fetch('http://127.0.0.1:8080/links', {
        method: 'GET',
        headers: jsonHeaders
    });
    if(!response.ok) {
        throw new FetchError(response.statusText, response.status);
    }
    return await response.json();
};

export async function submitLink(inputURL: string, inputTitle: string): Promise<Link> {
    const response = await fetch('http://127.0.0.1:8080/links', {
        method: 'POST',
        headers: jsonHeaders,
        body: JSON.stringify({ title: inputTitle, url: inputURL })
    });
    if (!response.ok) {
        throw new FetchError(response.statusText, response.status);
    }
    return await response.json();
};

export async function deleteLink(id: string): Promise<void> {
    const response = await fetch(`http://127.0.0.1:8080/links/${id}`, {
        method: 'DELETE',
        headers: jsonHeaders,
      });
      if (!response.ok) {
        throw new FetchError(response.statusText, response.status);
      }
};