@attached(conformance)
@attached(member, names: named(_phase), named(_resolvePhaseStateStore), named(SlidePhasedState), named(phase))
public macro Slide() = #externalMacro(module: "SlideKitMacros", type: "SlideMacro")
