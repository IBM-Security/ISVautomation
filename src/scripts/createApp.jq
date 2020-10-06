(
    (. + {"provisioningMode": ""}) | 
    (.provisioning.authentication.properties += {"pwd_erpassword": "agent"}) |
    (del(.icon)) |
    (del(.xforce)) |
    (del(.type))
)