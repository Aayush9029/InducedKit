
<div align="center">


<img src="https://github.com/Aayush9029/InducedKit/assets/43297314/0481f278-ac6b-413e-b419-8de3fc3194f0" width="128px">
  
# [InducedKit](http://induced.ai)

  </div>


## Introduction

The `InducedKit` Swift package provides a comprehensive SDK for interacting with the Induced AI API, facilitating the management of browser sessions and automating tasks using natural language processing. This package enables developers to seamlessly integrate Induced AI's capabilities into their Swift applications.

### Key Features

- Autonomous Browsing API integration
- Task extraction and management
- Support for macOS and iOS platforms

## Getting Started

### Prerequisites

- Swift 5.3 or later
- Xcode 12.0 or later
- An API key from Induced AI

### Installation

Add `InducedKit` to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/Aayush9029/InducedKit.git", from: "1.0.0")
]
```

### Usage

Import `InducedKit` in your Swift files and initialize the main classes with your API key:

```swift
import InducedKit

let inducedVM = InducedVM(apiKey: "your_api_key_here")
```

## Documentation

For detailed API usage and endpoint information, visit the [Induced Docs homepage](https://docs.induced.ai/).
