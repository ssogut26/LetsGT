const amplifyconfig =
    '''
 {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "letsgt": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://5tj7to7z7fecznvk2iqogbufmm.appsync-api.eu-central-1.amazonaws.com/graphql",
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
                        "ApiUrl": "https://5tj7to7z7fecznvk2iqogbufmm.appsync-api.eu-central-1.amazonaws.com/graphql",
                        "Region": "eu-central-1",
                        "AuthMode": "AMAZON_COGNITO_USER_POOLS",
                        "ClientDatabasePrefix": "letsgt_AMAZON_COGNITO_USER_POOLS"
                    },
                    "letsgt_AWS_IAM": {
                        "ApiUrl": "https://5tj7to7z7fecznvk2iqogbufmm.appsync-api.eu-central-1.amazonaws.com/graphql",
                        "Region": "eu-central-1",
                        "AuthMode": "AWS_IAM",
                        "ClientDatabasePrefix": "letsgt_AWS_IAM"
                    }
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "eu-central-1:54a6e740-dde6-4e31-97eb-8b08e79c58b9",
                            "Region": "eu-central-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "eu-central-1_N2CrNZzN7",
                        "AppClientId": "2v4kfmfsl4ci3ohe5uef537m1b",
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
