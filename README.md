# react-services-extras

Extra services for [react-services](https://github.com/ArseAssassin/react-services) to simplify common tasks.

## Enabling extra services

Install react-services-extras with

`npm install react-services-extras`

Require any services you need with

`require("react-services-extras/NavService")`

## Available services

### NavService

For implementing navigation for your single page application.

#### #path

Up to date path for the current URL. Defaults to current document.location.pathname when service is first required. Subscribe to this in your router component.

#### #navigate

Navigate to a new URL. If pushState is unavailable, document.location.href is overwritten instead. Handles relative URLs.

#### #title

The current title of the page. Fetched from the `<title>` element.

#### #setTitle

Update the current title of the page. Sets the content of the `<title>` element.

### JQueryService

Allows you to access jQuery.

#### #$

Polls `typeof $` until jQuery becomes available. If unavailable, returns null.

### DOMService

Allows you to access DOM elements.

#### #document

Returns the `document` object in browser.

#### #window

Returns the `window` object in browser.

#### #history

Returns the `history` object in browser.