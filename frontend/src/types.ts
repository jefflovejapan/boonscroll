export type Link = {
  id: string,
  url: string,
  title: string
}

export class FetchError extends Error {
  constructor(message: string, public statusCode: number) {
    super(message);
    this.name = 'FetchError';
  }
}