# Scratchpad

# Middleware

- How does FileMiddleware expose the contents of the public directory?
- What's happening if I don't enable FileMiddleware? How am I able to serve individual files? Or is it just that I'm reading the file and responding with a string?

## Plan

- Quit fumbling around, actually read the Vapor docs
- Actually read the React docs
- What does useState do?

## CORS

- React is being served on port 3000
- Vapor is served on 8080
- React can't request stuff from Vapor because of CORS
- "origin" -- domain, subdomain, port all together
- 

## Goals

- reload after adding a link successfully
- add a "createdAt" field to the link so we have some more certainty
- write a test to make sure URL validation is happening
- write a way to remove links