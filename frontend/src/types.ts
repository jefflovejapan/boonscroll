export type Link = {
  id: string,
  createdAt: Date,
  url: string,
  title: string
}

export class FetchError extends Error {
  constructor(message: string, public statusCode: number) {
    super(message);
    this.name = 'FetchError';
  }
}