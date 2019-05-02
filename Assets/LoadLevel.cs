using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LoadLevel : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Alpha1))
            SceneManager.LoadScene("3Shaders");
        else if (Input.GetKeyDown(KeyCode.Alpha3))
            SceneManager.LoadScene("CellularAutomata");
        else if (Input.GetKeyDown(KeyCode.Alpha2))
            SceneManager.LoadScene("ImageProcessing");
    }
}
