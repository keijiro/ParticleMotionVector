// ParticleMotionVector - Example implementation of motion vector writer for
// mesh particle systems | https://github.com/keijiro/ParticleMotionVector

using UnityEngine;
using UnityEditor;

namespace ParticleMotionVector
{
    class StandardOpaqueGUI : ShaderGUI
    {
        static class Styles
        {
            public static readonly GUIContent albedo = new GUIContent("Albedo");
            public static readonly GUIContent normalMap = new GUIContent("Normal Map");
        }

        public override void OnGUI(MaterialEditor editor, MaterialProperty[] props)
        {
            var texture = FindProperty("_MainTex", props);
            var option = FindProperty("_Color", props);
            editor.TexturePropertySingleLine(Styles.albedo, texture, option);

            EditorGUILayout.Space();

            editor.ShaderProperty(FindProperty("_Glossiness", props), "Smoothness");
            editor.ShaderProperty(FindProperty("_Metallic", props), "Metallic");

            EditorGUILayout.Space();

            texture = FindProperty("_BumpMap", props);
            option = texture != null ? FindProperty("_BumpScale", props) : null;
            editor.TexturePropertySingleLine(Styles.normalMap, texture, option);
        }
    }
}
