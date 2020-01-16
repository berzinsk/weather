# Weather App

## BDD Specs

### Story: User requests to see current weather

> As an online user
I want the app to automatically load current weather data
So I can always see the latest weather data
#### Scenarios (Acceptance criteria)

```
Given the user has connectivity
When the user requests to see wwather data
Then the app should display the latest weather information from remote
And replace the cache with the new information
```

### Narrative #2
> As an offline user
I want the app to show the latest saved version of the weather
So I can know approximate weather conditions
#### Scenarios (Acceptance criteria)

```
Given the user doesn't have connectivity
And there's a cached version of the weather information
When the user requests to see the weather information
Then the app should display the latest weather information saved
Given the user doesn't have connectivity
And the cache is empty
When the user requests to see the weather information
Then the app should display an error message
```

## Use Cases

### Load Current Weather Information Use Case

#### Data:
- URL

#### Primary course (happy path):
1. Execute "Load Current Weather Information" command with the above data.
2. System downloads data from the URL.
3. System validates downloaded data.
4. System creates current weather information item from valid data.
5. System delivers current weather information.

#### Invalid data - error course (sad path):
1. System delivers error.

#### No connectivity - error course (sad path):
1. System delivers error.

### Load Weather Information Fallback (Cache) Use Case

#### Data:
- Max age

#### Primary course (happy path):
1. Execute "Retrieve Current Weather Information" command with the above data.
2. System fetches weather information from cache.
3. System validates cache age.
4. System creates weather information object from cached data.
5. System delivers weather information.

#### Expired cache course (sad path):
1. System delivers no weather information.

#### Empty cache course (sad path):
1. System delivers no weather information.

### Save Weather Information Use Case

#### Data:
- Weather Information

#### Primary course (happy path):
1. Execute "Save Current Weather Information" command with above data.
2. System encodes weather information.
3. System timestamps the new cache.
4. System replaces the cache with new data.
5. System delivers success message.

## Model Spec

### Current Weather

| Property      | Type          |
|---------------|---------------|
| `id`          | `String`      |
| `weather`     | `Weather`     |
| `wind`        | `Wind`        |

### Weather

| Property      | Type          |
|---------------|---------------|
| `id`          | `String`      |
| `main`        | `String`      |
| `description` | `String`      |
| `icon`        | `String`      |

### Wind

| Property      | Type          |
|---------------|---------------|
| `speed`       | `Double`      |


### Payload contract
