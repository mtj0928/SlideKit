@attached(conformance)
@attached(member, names: named(_phase), named(_phaseStore), named(SlidePhasedState), named(phase))
public macro SlidePage() = #externalMacro(module: "SlideKitMacros", type: "SlidePageMacro")
