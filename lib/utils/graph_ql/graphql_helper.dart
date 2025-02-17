// // Flutter imports:

// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';

// // Package imports:
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:defenders/config/manager/storage_manager.dart';
// import 'package:defenders/constants/app_storage_key.dart';
// import 'package:defenders/utils/api_path.dart';
// import 'package:defenders/utils/progress_indicator.dart';

// class GraphQLHelper {
//   GraphQLHelper();
//   static Circle processIndicator = Circle();

//   // static Circal processIndicator = new Circal();

//   // Setup Client
//   static Future<GraphQLClient> getClient() async {
//     String? token =
//         StorageManager.getStringValue(AppStorageKey.authorizatioToken);
//     // dataStorage.read('token');

//     HttpLink httpLink;
//     if (token != null) {
//       httpLink = HttpLink(
//         ApiPath.graphQlEndPoint,
//         defaultHeaders: <String, String>{
//           'Authorization': token,
//           'x-hasura-admin-secret':
//               "qENSkzxXNs4iHt0Ik4r6ttsCxOKXjo031azEAKNN9sw6YEhCtvkt2BV9Q2J8YICQ",
//           'content-type': 'application/json'
//         },
//       );
//     } else {
//       httpLink = HttpLink(ApiPath.graphQlEndPoint, defaultHeaders: {
//         'Hasura-Client-Name': 'hasura-console',
//         'x-hasura-admin-secret':
//             "qENSkzxXNs4iHt0Ik4r6ttsCxOKXjo031azEAKNN9sw6YEhCtvkt2BV9Q2J8YICQ",
//         'content-type': 'application/json'
//       });
//     }
//     Link link = httpLink;
//     GraphQLClient client = GraphQLClient(
//       cache: GraphQLCache(),
//       link: link,
//     );
//     return client;
//   }

//   // GraphQL Query Execution
//   static Future<QueryResult> gqlQuery(String document,
//       {Map<String, dynamic>? variables, BuildContext? context}) async {
//     // for the show process indicator
//     Future.delayed(const Duration(milliseconds: 10), () async {
//       if (context != null) await processIndicator.show(context);
//     });

//     // Setup token if not exist
//     // if (token == null) tokenValue = getToken();
//     // Get Client Object
//     GraphQLClient client = await getClient();
//     // Execute GraphQL Query
//     final QueryResult result;
//     if (variables != null) {
//       result = await client.query(
//         QueryOptions(document: gql(document), variables: variables),
//       );
//     } else {
//       result = await client.query(
//         QueryOptions(
//           document: gql(document),
//         ),
//       );
//     }

//     // for hide process indicator
//     if (context != null) processIndicator.hide(context);

//     return result;
//   }

//   // GraphQL Mutation Execution
//   static Future<QueryResult> gqlMutation(
//       String document, Map<String, dynamic> variables,
//       {BuildContext? context}) async {
//     // for the show process indicator
//     if (context != null) await processIndicator.show(context);

//     // Setup token if not exist
//     // tokenValue = getToken();
//     // Get Client Object
//     GraphQLClient client = await getClient();
//     // Execute GraphQL Mutation
//     final QueryResult result = await client.mutate(
//       MutationOptions(document: gql(document), variables: variables),
//     );
//     // for hide process indicator
//     if (context != null) processIndicator.hide(context);

//     return result;
//   }

//   static Future<QueryResult> gqlMutationWithoutLoading(
//       String document, Map<String, dynamic> variables,
//       {BuildContext? context}) async {
//     // for the show process indicator
//     // if (context != null) await processIndicator.show(context);

//     // Setup token if not exist
//     // tokenValue = getToken();
//     // Get Client Object
//     GraphQLClient client = await getClient();
//     // Execute GraphQL Mutation
//     final QueryResult result = await client.mutate(
//       MutationOptions(document: gql(document), variables: variables),
//     );
//     // for hide process indicator
//     // if (context != null) processIndicator.hide(context);

//     return result;
//   }
// }
