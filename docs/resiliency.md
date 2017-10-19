# Resiliency

A resilient system keeps processing transactions, even when there are transient impulses, persistent stresses, or component failures disrupting normal processing.

[Back to cognitive root project](../README.md)

## The challenges
Watson Services are deployed in data center with support for high availability by using two node cluster. It may be needed to add a second data center and replicates service configuration so services are available and can be consumed by your own web application. As distribute environment. some failure may happen. You need to control the interactions with those services and avoid the traditional production issues like cascading failures.


## A Potential Solution
The different Cognitive service `cyan compute` are protected by the [hystrixjs](https://www.npmjs.com/package/hystrixjs) module to implement circuit-breaker and clean failure management. It also help gathering some performance measures like:
* successes
* failures
* number of timeouts
* number of short circuits

As illustrated in the diagram below the following logic is done:

* wrap each call to a Cognitive distributed service inside a command
* configure the command with the different settings for timeout, concurrency, and circuit threshold
* when the maximum number of concurrent requests is reached on one service reach a second end point.  

measures execution times
trips a circuit-breaker to stop all requests to a particular service for a period of time, if the error percentage for this service passes a configured threshold
performs fallback logic, when the execution fails, times out or is short-circuits
provides a SSE of metrics, which can be visualized in Hystrix Dashboard for near real-time monitoring
