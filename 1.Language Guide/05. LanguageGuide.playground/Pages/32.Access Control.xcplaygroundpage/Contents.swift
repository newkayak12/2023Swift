//: [Previous](@previous)
import Foundation
/*: # Access Control*/
/**
 `Access control` restrict access to parts of your code from code in other source files and modules. This feature enables you to hide the implementation details of your code, and to specify a preferred interface through which that code can be accessed and used.
 
 You can assign specific access levels to individual types (classes, structures, and enumerations), as well as to properties, methods, initializers, and subscripts belonging to those types. Protocols can be restricted to a certain context, as can global constants, variables, and functions.
 
 In addition to offereing various levels of access control, Swift reduces the need to specify explicit access control levels by providing default access levels for typical scenarios. Indeed, if you are writing a single-target app, you may not need to specify explicit access control levels at all.
 
            The various aspects of your code that can have access control applied to them (properties, types, functions, and so on) are referred to as "entities" in the section below, for brevity.
 
 
    Modules and Source Files
 Swift's access control model is based on the concept of modules and source files.
 
 A `module` is a single unit of code distribution - a framework or application that's built and shipped as a single unit and that can be imported by another module with Swift's `import` keyword.
 
 Each build target (such as an app bundle or framework) in Xcode is treated as a separate module in Swift. If you group together aspects of you app's code as a stand-alone framework - perhaps to encapsulate and reuse that code across multiple applications - then everything you define within that framework will be part of a separate module when it's imported and used within an app, or when it's used within another framework.
 
 A `source file` is a single Swift source code file within a module. Although it's common to define individual types in separate source files, a single source file can contain definitions for multiple types, functions, and so on.
 
 
 
    Access Levels
 Swift provides five different `access levels` for entities within your code. These access levels are relative to the source file in which an entity is defined, and also relative to the module that source file belongs to.
 
    - `Open` access and `public` access enable to be used within any source file from their defining module, and also in a source file from another module that imports the defining module. You typically use open or public access when specifying the public interface to a framework. The difference between open and public access is described below.
 
    - `Internal` access enables entities to be used within any source file from their defining module, but not in any source file outside of that module. You typically use internal access when defining an app's or a framework's interal structure.
 
    - `File-private` access restricts the use of an entity to its own defining source file. Use file-private access to hide the implementation details of a specific piece of functionality when those details are used within an entire file.
 
    - `Private` access restricts the use of an entity to the enclosing declaration, and to extensions of that declaration that are in the same file. Use private access to hide the implementation details of a speicific piece of funcitonality when those details are used only within a single declaration.
 
 Open access is the highest access level and private access is the lowest access level.
 
 Open access applies only to classes and class members, and it differs from public access by allowing code outside the module to subclass and override, as discussed below in `Subclassing`. Marking a class as open explicitly indicates that you've considered the impact of code from other modules using that class as a superclass, and that you've designed your class's code accordingly.
 */


//: [Next](@next)
