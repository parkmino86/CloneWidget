# CloneWidget Project

## Overview

`CloneWidget`은 모듈화된 구조와 현대적인 아키텍처 패턴(TCA, The Composable Architecture)을 기반으로 한 iOS 애플리케이션입니다. 이 프로젝트는 기능별로 분리된 구조와 공통 컴포넌트, 네트워크, 유틸리티 등을 포함하여 확장성과 유지보수성을 고려한 설계를 목표로 하고 있습니다.

## Project Structure

프로젝트는 다음과 같은 주요 디렉토리로 구성되어 있습니다:

### 1. Application
- 애플리케이션의 전반적인 구성 요소를 포함합니다.
- 하위 디렉토리:
  - **Features**: 애플리케이션의 주요 기능들이 위치한 곳으로, 각 기능별로 별도의 디렉토리로 분리되어 있습니다.
  - **Services**: API 서비스와 관련된 모듈이 위치합니다.
  - **Widget**: 위젯 관련 모듈이 위치합니다.
  - **Core**: 공통으로 사용되는 리소스와 유틸리티를 포함합니다.
  - **CloneWidgetApp.swift**: 애플리케이션의 진입점이 되는 파일입니다.

### 2. Features
- 앱의 주요 기능들을 포함합니다. 각 기능은 독립적인 폴더로 관리됩니다.
- 하위 디렉토리:
  - **Root**: 앱의 루트 뷰와 도메인 관련 파일들이 위치합니다.
  - **Today**: 오늘의 뷰와 도메인 관련 파일들이 위치합니다.
  - **Foto**: 사진과 관련된 뷰와 도메인 파일들이 위치합니다.
  - **Explorer**: 탐색 관련 뷰와 도메인 파일들이 위치합니다.
  - **MyPage**: 사용자 페이지 관련 뷰와 도메인 파일들이 위치합니다.

### 3. Core
- 공통적으로 사용되는 리소스와 유틸리티를 포함합니다.
- 하위 디렉토리:
  - **DesignSystem**: UI 디자인 시스템과 관련된 컴포넌트들이 위치합니다.
  - **Logger**: 로그 시스템을 관리하는 모듈들이 위치합니다.
  - **Network**: 네트워크 관련 모듈들이 위치합니다.
  - **Utility**: 다양한 유틸리티 모듈들이 위치합니다.

### 4. Services
- API 서비스와 관련된 모듈들이 위치합니다.
- 하위 디렉토리:
  - **APIService**: API 호출 및 데이터 처리와 관련된 모듈들이 위치합니다.

## Dependencies

프로젝트는 다음과 같은 외부 의존성을 사용합니다:

- **swift-composable-architecture**: TCA 패턴을 적용하여 상태 관리와 비즈니스 로직을 구성합니다.
  - Repository: [https://github.com/pointfreeco/swift-composable-architecture](https://github.com/pointfreeco/swift-composable-architecture)
  - Minimum Version: `1.12.1`

## Build Configurations

프로젝트는 두 가지 빌드 구성을 제공합니다:

- **Debug**: 디버그용 설정으로, 최적화가 비활성화되고 디버그 정보를 포함합니다.
- **Release**: 배포용 설정으로, 최적화가 활성화되고 디버그 정보가 최소화됩니다.

## Getting Started

### Prerequisites

- Xcode 14.0 이상
- iOS 17.5 이상을 타겟으로 빌드
