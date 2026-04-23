# Use the official Dart SDK image to build the app
FROM dart:stable AS build

# Set the working directory
WORKDIR /app

# Copy the shelf package files
COPY pkgs/shelf/ .

# Get dependencies
RUN dart pub get

# Compile the example to an AOT executable
RUN dart compile exe example/example.dart -o example

# Use a smaller runtime image
FROM dart:stable

# Set the working directory
WORKDIR /app

# Copy the compiled executable from the build stage
COPY --from=build /app/example .

# Expose the port the app runs on
EXPOSE 8080

# Run the app
CMD ["./example"]