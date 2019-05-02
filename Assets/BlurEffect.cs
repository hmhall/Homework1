using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BlurEffect : MonoBehaviour
{
    public Material jables;
    int blur;
    // Start is called before the first frame update
    void Start()
    {
        blur = 0;
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.LeftArrow)&& blur > 0) {
            blur--;
            jables.SetInt("_Blur", blur);
        }
        else if (Input.GetKeyDown(KeyCode.RightArrow) && blur < 10)
        {
            blur++;
            jables.SetInt("_Blur", blur);
        }
    }
}
