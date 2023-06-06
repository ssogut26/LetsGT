import 'package:letsgt/core/usecases/environment_variables.dart';

const amplifyconfig = '''
 {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "letsgt": {
                    "endpointType": "GraphQL",
                    "endpoint": "${EnvironmentVariables.endpoint}",
                    "region": "eu-central-1",
                    "authorizationType": "AMAZON_COGNITO_USER_POOLS"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl":"${EnvironmentVariables.endpoint}",
                        "Region": "eu-central-1",
                        "AuthMode": "AMAZON_COGNITO_USER_POOLS",
                        "ClientDatabasePrefix": "letsgt_AMAZON_COGNITO_USER_POOLS"
                    },
                    "letsgt_AWS_IAM": {
                        "ApiUrl": "${EnvironmentVariables.endpoint}",
                        "Region": "eu-central-1",
                        "AuthMode": "AWS_IAM",
                        "ClientDatabasePrefix": "letsgt_AWS_IAM"
                    }
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "PoolId": "${EnvironmentVariables.cognitoIdentityPoolId}",
                            "Region": "eu-central-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                         "PoolId": "${EnvironmentVariables.cognitoUserPoolId}",
                        "AppClientId": "${EnvironmentVariables.clientId}",
                        "Region": "eu-central-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "socialProviders": [],
                        "usernameAttributes": [
                            "EMAIL",
                            "PHONE_NUMBER"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "letsgt-storage-773682b8210826-dev",
                        "Region": "eu-central-1"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "letsgt-storage-773682b8210826-dev",
                "region": "eu-central-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';

