output "davinci_connection_Annotation_id" {
    value = davinci_connection.Annotation.id

}
output "davinci_connection_Error-Message_id" {
    value = davinci_connection.Error-Message.id
}
output "davinci_connection_Functions_id" {
    value = davinci_connection.Functions.id
}
output "davinci_connection_Http_id" {
    value = davinci_connection.Http.id
}
output "davinci_connection_Challenge_id" {
    value = davinci_connection.Challenge.id
}
output "davinci_connection_Flow-Connector_id" {
    value = davinci_connection.Flow-Connector.id
}
output "davinci_connection_Node_id" {
    value = davinci_connection.Node.id
}
output "davinci_connection_Variables_id" {
    value = davinci_connection.Variables.id
}
output "davinci_connection_PingOne_id" {
    value = davinci_connection.PingOne.id
}
output "davinci_connection_PingOne-MFA_id" {
    value = davinci_connection.PingOne-MFA.id
}
output "davinci_connection_PingOne-Authorize_id" {
    value = davinci_connection.PingOne-Authorize.id
}
output "davinci_connection_PingOne-Notifications_id" {
    value = davinci_connection.PingOne-Notifications.id
}

output "davinci_connection_PingOne-Verify_id" {
    value = davinci_connection.PingOne-Verify.id
}

output "davinci_connection_PingOne-Protect_id" {
    value = davinci_connection.PingOne-Protect.id
}

output "davinci_connection_PingOne-Authentication_id" {
    value = davinci_connection.PingOne-Authentication.id
}

output "davinci_connections_read_connections" {
    value = data.davinci_connections.read_connections
}