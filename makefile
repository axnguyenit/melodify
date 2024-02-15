ENV ?= dev
FVM ?= fvm

setup-env:
	cp ./envs/$(ENV)/google-services.json ./app/android/app/google-services.json
	cp ./envs/$(ENV)/GoogleService-Info.plist ./app/ios/GoogleService-Info.plist
	cp ./envs/$(ENV)/.env ./app/.env
	cp ./envs/$(ENV)/.env ./data/.env

get-deps:
	cd analysis_defaults && $(FVM) flutter pub get
	cd core && $(FVM) flutter pub get
	cd data && $(FVM) flutter pub get
	cd domain && $(FVM) flutter pub get
	cd app && $(FVM) flutter pub get
	cd initializer && $(FVM) flutter pub get
	cd resources && $(FVM) flutter pub get
	cd storybook && $(FVM) flutter pub get

run:
	make setup-env
	cd app && $(FVM) flutter run -t lib/main.dart --flavor $(ENV)

run-release:
	make setup-env
	cd app && $(FVM) flutter run --flavor $(ENV) --release

run-storybook:
	make setup-env
	cd storybook && $(FVM) flutter run -t lib/main.dart

build-apk:
	make setup-env
	cd app && $(FVM) flutter build apk --flavor $(ENV) --release

build-appbundle:
	cd app && $(FVM) flutter build appbundle --flavor $(ENV) --release

build-ios:
	cd app && $(FVM) flutter build ios --flavor $(ENV) --release

build-ipa:
	cd app && $(FVM) flutter build ipa --release --export-options-plist=ios/ExportOptions.plist --flavor $(ENV)

gen:
	make data-gen FVM=$(FVM)
	make domain-gen FVM=$(FVM)
	make app-gen FVM=$(FVM)

data-gen:
	cd data && make gen FVM=$(FVM)

domain-gen:
	cd domain && make gen FVM=$(FVM)

app-gen:
	cd app && make gen FVM=$(FVM)

data-watch:
	cd data && make watch FVM=$(FVM)

domain-watch:
	cd domain && make watch FVM=$(FVM)

watch:
	cd app && make watch FVM=$(FVM)

clear-pod:
	cd ios && rm Podfile.lock
	pod cache clean --all
	sudo arch -x86_64 pod install --repo-update
	pod repo update
	pod install