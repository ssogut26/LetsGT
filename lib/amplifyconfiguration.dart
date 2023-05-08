import 'package:flutter_dotenv/flutter_dotenv.dart';

final endpoint = dotenv.env['GRAPHQL_ENDPOINT'];
final cognitoIdentityPoolId = dotenv.env['COGNITO_IDENITY_POOL_ID'];
final cognitoUserPoolId = dotenv.env['COGNITO_USER_POOL_ID'];
final appClientId = dotenv.env['APP_CLIENT_ID'];

final amplifyconfig =
    '''
 {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "letsgt": {
                    "endpointType": "GraphQL",
                    "endpoint": "$endpoint",
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
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "$cognitoIdentityPoolId",
                            "Region": "eu-central-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "$cognitoUserPoolId",
                        "AppClientId": "$appClientId",
                        "Region": "eu-central-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "socialProviders": [],
                        "usernameAttributes": [
                            "EMAIL",
                            "PHONE_NUMBER"
                        ],
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "$endpoint",
                        "Region": "eu-central-1",
                        "AuthMode": "AMAZON_COGNITO_USER_POOLS",
                        "ClientDatabasePrefix": "letsgt_AMAZON_COGNITO_USER_POOLS"
                    }
                }
            }
        }
    }
}''';
