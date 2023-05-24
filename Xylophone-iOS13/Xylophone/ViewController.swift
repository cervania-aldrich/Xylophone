import UIKit
import AVFoundation //The framework we use to play sound (See docs for more information)

class ViewController: UIViewController {
    
    //The object used to the play audio. Set as Optional because we create an audio player only when audio is played.
    var audioPlayer: AVAudioPlayer?
    
    /**
     A function to specifics what should happen when a button is pressed. This function is called when a button is pressed. Also, this @IBAction is linked to multiple buttons, which means this function is called when either of those connected buttons have been pressed.
     
     As for what does the function do:
     1. Firstly, the 'sender' parameter is of type 'UIButton,' and UIButton's have a bunch of properties that we could change (See more in the attributes inspector). One of them is the 'currentTitle' property which is of type 'String.' This property refers to the current title of the button, and it's the information that will be used to reference each button. We store this information in a variable called "key."
     Functions with @IBAction tags are not called like normal functions. It is called when a button is presse. Which means the currentTitle property will equal nil (i.e. "key" will not have a value) until the function is called. Hence why we wrap the variable with a guard statement. (In future modules we learn about force unwrapping, optionals and guard statements but for now at this level of the course, we had forced unwrapped "key" instead of using a guard statement)
     
     2. Once we get that button reference (which we will when the user has pressed a button, therefore "key" WILL have a value), we pass this information into the function:
     ```
     func play(_ keySound: String)
     ```
     Afterwards, we shall also pass the 'sender' to another function to do more instructions. That function is:
     ```
     func changeOpacity(of button: UIButton)
     ```
     Passing arguments to parameters is a way of passing information from one function to another (Function scope). Also, inputs can be incoporated into the body of the function to do something different every time which makes the function reusable. In our app, we are passing a different 'key' (based on the which key was pressed) to call the 'play()' function to play different sounds, rather than just always play the "C" note (prior to refactoring).
     
     - parameter sender: Refers to the identity of the button as a whole.
    */
    
    @IBAction func keyPressed(_ sender: UIButton) {
        
        // Uniquely identifies a button based on a string value. Continue the code if key does not equal nil.
        guard let key = sender.currentTitle else {return}
        
        //Play the desired key sound.
        ///Code-lingo we say "Call the 'play' function by passing the 'key' argument to the 'keySound' parameter"
        ///Or "Pass the 'key' as the argument to the 'keySound' parameter of the 'play' function. This also calls the function."
        play(key)
        
        //Change the opacity of the button that was pressed (For a better UI aesthetics).
        changeOpacity(of:sender)

    }
    
    /**
     A function (i.e instructions) to play a sound file from a local resource.
     
     Unlike the @IBAction function, this function is not called based on a users action. To call this function (with inputs), we do it programmatically:
     ```
     play(key)
     ```
     However, a requisite to calling a function with inputs is to ensure that we provide an argument for the (input) parameter. Which we have done by passing the 'key' argument to the 'keySound' parameter. Xcode will also warn us to provide the neccessary arguments to a function if we don't.
     
     For a better understanding of functions, it can be useful to picture functions as a machine where: Input -> Code -> Output. For example:
     - "C" -> play("C") -> C.wav (Input "C" to the play function, play C.wav file)
     - "D" -> play("D") -> D.wav (Input "D" to the play function, play D.wav file)
     - "E" -> play("E") -> E.wav (Input "E" to the play function, play E.wav file)
     
     **Functions with inputs impact the output of the function ,whereas Functions with no inputs behave the same way every time.**
     
     As for what does the function do:
     1. Define a URL to the sound file based on the 'keySound.'
     2. Define the AVAudioSession. (This configures how audio should behave for our app. We define this because it helps the OS know how to coordinate the audios usage with other resources. For example, should the app play audio when silent mode is on? What happens to the audio when someone is calling you? Or when you are video recording? Audio is a shared resource on a device, and more interactions like this are handled with the AVAudioSession object.)
     3. Create an audioPlayer.
     4. Play the audio from the audioPlayer.
     
     - parameter keySound: A variable defined with the String type so that we can pass String arguments to this String parameter. We use this String value to reference the correct sound resource.
     */
    
    func play(_ keySound: String){
        
        //References the location of the wav files in the local disk. (Like finding where your CD's are)
        //Check if keySoundURL does not equal nil before we continue with the code.
        guard let keySoundURL = Bundle.main.url(forResource: keySound, withExtension: "wav") else { return }
        
        do {
            //Communicate to the device the general nature of the apps audio.
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            
            //Initialise the audioPlayer to play the audio from the keySoundURL (Like selecting the CD you want to play).
            audioPlayer = try AVAudioPlayer(contentsOf: keySoundURL)
            
            //Play from the player (Like pressing play on an audio player to play your CD).
            audioPlayer?.play()
            
        } catch {
            print("Error playing sound: \(error)") //If any errors, print the error to the console.
        }
    }
    
    /**
    A function that changes the opacity of a button from 50% to 100%.
     
    In future modules we learn about internal and external parameter names, where "of" is an external p arameter name, and "button" is the internal parameter name.
     
     - parameter button: Refers to the button we want to change the opacity of.
     */
    
    func changeOpacity(of button: UIButton){
        
        //Set button opacity to 50%...
        button.alpha = 0.5
        
        //... Then bring the button opacity back to opaque with a smooth animation.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIView.animate(withDuration: 0.3) {
                button.alpha = 1.0
            }
        }
    }
    
}

