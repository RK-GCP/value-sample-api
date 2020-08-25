# value-sample-api
value-sample-api
Next Version to Include helm chart

```
Probes cheat sheet for Kube Deployment
```

# Configure Probes

Probes have a number of fields that you can use to more precisely control the behavior of liveness and readiness checks:

- `initialDelaySeconds:` Number of seconds after the container has started before liveness or readiness probes are initiated. Defaults to 0 seconds. Minimum value is 0.
- `periodSeconds:` How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.
- `timeoutSeconds:` Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1.
- `successThreshold:` Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness. Minimum value is 1.
- `failureThreshold:` When a probe fails, Kubernetes will try failureThreshold times before giving up. Giving up in case of liveness probe means restarting the container. In case of readiness probe the Pod will be marked Unready. Defaults to 3. Minimum value is 1.

## HTTP probes have additional fields that can be set on `httpGet`:

- `host:` Host name to connect to, defaults to the pod IP. You probably want to set "Host" in httpHeaders instead.
- `scheme:` Scheme to use for connecting to the host (HTTP or HTTPS). Defaults to HTTP.
- `path:` Path to access on the HTTP server.
- `httpHeaders:` Custom headers to set in the request. HTTP allows repeated headers.
- `port:` Name or number of the port to access on the container. Number must be in the range 1 to 65535.

For an `HTTP` probe, the kubelet sends an HTTP request to the specified path and port to perform the check. The kubelet sends the probe to the pod’s IP address, unless the address is overridden by the optional host field in httpGet. If scheme field is set to `HTTPS`, the kubelet sends an HTTPS request skipping the certificate verification. In most scenarios, you do not want to set the host field. Here's one scenario where you would set it. Suppose the container listens on `127.0.0.1` and the Pod's hostNetwork field is true. Then host, under httpGet, should be set to 127.0.0.1. If your pod relies on virtual hosts, which is probably the more common case, you should not use host, but rather set the Host header in httpHeaders.

For a TCP probe, the kubelet makes the probe `connection at the node`, not in the pod, which means that you `can not use a service name in the host parameter` since the kubelet is unable to resolve it.
