/**
 * @name Code injection
 * @description Interpreting unsanitized user input as code allows a malicious user arbitrary
 *              code execution.
 * @kind path-problem
 * @problem.severity error
 * @id py/code-injection-local
 * @tags security
 *       external/owasp/owasp-a1
 *       external/cwe/cwe-094
 *       external/cwe/cwe-095
 *       external/cwe/cwe-116
 */
import python
import semmle.python.security.Paths
/* Sources */
import semmle.python.web.HttpRequest
/* Sinks */
import semmle.python.security.injection.Exec
class LocalInputSource extends TaintTracking::Source {
    LocalInputSource() {
        this = Value::named("input").getACall()
    }
    override predicate isSourceOf(TaintKind kind) {
        kind instanceof ExternalStringKind
    }
}
class CodeInjectionConfiguration extends TaintTracking::Configuration {
    CodeInjectionConfiguration() { this = "Code injection configuration" }
    override predicate isSource(TaintTracking::Source source) {
        source instanceof HttpRequestTaintSource or
        source instanceof LocalInputSource
    }
    override predicate isSink(TaintTracking::Sink sink) { sink instanceof StringEvaluationNode }
}
from CodeInjectionConfiguration config, TaintedPathSource src, TaintedPathSink sink
where config.hasFlowPath(src, sink)
select sink.getSink(), src, sink, "$@ flows to here and is interpreted as code.", src.getSource(),
    "A user-provided value"
